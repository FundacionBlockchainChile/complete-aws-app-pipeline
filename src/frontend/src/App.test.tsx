import { render, screen } from '@testing-library/react';
import App from './App';

describe('App Component', () => {
  it('renders learn react link', () => {
    render(<App />);
    const linkElement = screen.getByText(/learn react/i);
    expect(linkElement).toBeInTheDocument();
  });

  it('renders without crashing', () => {
    const { container } = render(<App />);
    expect(container).toBeInTheDocument();
  });
});
